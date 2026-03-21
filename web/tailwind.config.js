/** @type {import('tailwindcss').Config} */
export default {
  darkMode: ["class"],
  content: [
    "./src/**/*.{ts,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        "geo-primary": "#1f77b4",
        "geo-accent": "#ff7800",
        "geo-success": "#2e7d32",
      }
    },
  },
  plugins: [],
}
