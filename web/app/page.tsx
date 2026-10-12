const AUDIENCES = ["HR", "Company", "Admin"] as const;

export default function Home() {
  return (
    <main style={{ fontFamily: "system-ui, sans-serif", padding: "3rem", lineHeight: 1.6 }}>
      <h1 style={{ marginBottom: "0.25rem" }}>DreamTrillions EMS</h1>
      <p style={{ marginTop: 0, opacity: 0.75 }}>
        Employment Management System — web portal
      </p>

      <h2>Portal audiences</h2>
      <ul>
        {AUDIENCES.map((audience) => (
          <li key={audience}>{audience}</li>
        ))}
      </ul>

      <p style={{ marginTop: "2rem", opacity: 0.75 }}>
        Backend API base URL:{" "}
        <code>{process.env.NEXT_PUBLIC_API_BASE_URL ?? "http://localhost:8080/api"}</code>
      </p>
    </main>
  );
}