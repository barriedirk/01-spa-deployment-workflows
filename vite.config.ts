import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  base: "/mi-bucket-frontend/", // Esto hace que Vite ponga /mi-bucket-frontend/ al inicio de todas las rutas
});
