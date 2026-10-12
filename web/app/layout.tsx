import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "DT EMS — Portal",
  description:
    "Employment Management System portal for HR, company and admin staff",
};

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}