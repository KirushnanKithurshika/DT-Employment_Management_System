-- DreamTrillions Employment Management System — initial schema.
--
-- Executed automatically by the postgres image the first time the db volume
-- is created (see db/init mount in docker-compose.yml). Files run in
-- alphabetical order.
--
-- Migrations are additive: never edit a script that has already been applied
-- to a shared database, add a new numbered file instead.

-- ---------------------------------------------------------------------------
-- Core reference tables
-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS departments (
    id          BIGSERIAL PRIMARY KEY,
    code        VARCHAR(32)  NOT NULL UNIQUE,
    name        VARCHAR(160) NOT NULL,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS designations (
    id            BIGSERIAL PRIMARY KEY,
    code          VARCHAR(32)  NOT NULL UNIQUE,
    title         VARCHAR(160) NOT NULL,
    department_id BIGINT       NOT NULL REFERENCES departments (id),
    created_at    TIMESTAMPTZ  NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS branches (
    id         BIGSERIAL PRIMARY KEY,
    code       VARCHAR(32)  NOT NULL UNIQUE,
    name       VARCHAR(160) NOT NULL,
    address    TEXT,
    created_at TIMESTAMPTZ  NOT NULL DEFAULT now()
);

-- ---------------------------------------------------------------------------
-- Employees
-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS employees (
    id             BIGSERIAL PRIMARY KEY,
    employee_number VARCHAR(32) NOT NULL UNIQUE,
    first_name     VARCHAR(120) NOT NULL,
    last_name      VARCHAR(120),
    email          VARCHAR(254) NOT NULL UNIQUE,
    phone          VARCHAR(32),
    date_of_birth  DATE,
    date_joined    DATE         NOT NULL,
    employment_status VARCHAR(32) NOT NULL DEFAULT 'ACTIVE',
    department_id  BIGINT       NOT NULL REFERENCES departments (id),
    designation_id BIGINT       NOT NULL REFERENCES designations (id),
    branch_id      BIGINT       NOT NULL REFERENCES branches (id),
    created_at     TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at     TIMESTAMPTZ  NOT NULL DEFAULT now(),

    CONSTRAINT employees_status_check
        CHECK (employment_status IN ('ACTIVE', 'ON_LEAVE', 'SUSPENDED', 'RESIGNED', 'TERMINATED'))
);

CREATE INDEX IF NOT EXISTS idx_employees_department ON employees (department_id);
CREATE INDEX IF NOT EXISTS idx_employees_branch     ON employees (branch_id);
CREATE INDEX IF NOT EXISTS idx_employees_status     ON employees (employment_status);

-- Keeps updated_at honest without relying on application code.
CREATE OR REPLACE FUNCTION touch_updated_at() RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_employees_updated_at ON employees;
CREATE TRIGGER trg_employees_updated_at
    BEFORE UPDATE ON employees
    FOR EACH ROW
    EXECUTE FUNCTION touch_updated_at();

-- ---------------------------------------------------------------------------
-- Leave records (employee self-service via the mobile app)
-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS leave_requests (
    id           BIGSERIAL PRIMARY KEY,
    employee_id  BIGINT      NOT NULL REFERENCES employees (id) ON DELETE CASCADE,
    leave_type   VARCHAR(64) NOT NULL,
    start_date   DATE        NOT NULL,
    end_date     DATE        NOT NULL,
    reason       TEXT,
    status       VARCHAR(32) NOT NULL DEFAULT 'PENDING',
    created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT leave_requests_date_check CHECK (end_date >= start_date),
    CONSTRAINT leave_requests_status_check
        CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED', 'CANCELLED'))
);

CREATE INDEX IF NOT EXISTS idx_leave_requests_employee ON leave_requests (employee_id);
CREATE INDEX IF NOT EXISTS idx_leave_requests_status   ON leave_requests (status);

DROP TRIGGER IF EXISTS trg_leave_requests_updated_at ON leave_requests;
CREATE TRIGGER trg_leave_requests_updated_at
    BEFORE UPDATE ON leave_requests
    FOR EACH ROW
    EXECUTE FUNCTION touch_updated_at();