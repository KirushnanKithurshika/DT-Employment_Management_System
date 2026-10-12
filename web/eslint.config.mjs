import next from "eslint-config-next";

/**
 * ESLint flat config (ESLint 9 / ESLint 10 no longer read .eslintrc.* files).
 *
 * `eslint-config-next` exports an array of flat config objects, so it is spread
 * into this config rather than being nested under `extends`.
 */
export default [
  ...next,
  {
    ignores: [
      ".next/**",
      "out/**",
      "build/**",
      "node_modules/**",
      "next-env.d.ts",
    ],
  },
];