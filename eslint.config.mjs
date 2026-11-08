import js from "@eslint/js";
import globals from "globals";

export default [
  { ignores: ["node_modules/**"] },
  js.configs.recommended,
  {
    files: ["js/**/*.js"],
    languageOptions: {
      sourceType: "script",
      globals: globals.browser,
    },
  },
  {
    // The bundled MD5 helper supports CommonJS as well as browsers.
    files: ["js/md5.js"],
    languageOptions: { globals: { module: "readonly" } },
  },
];
