import * as React from "react"
import { cn } from "@/lib/utils"

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: "default" | "secondary" | "ghost" | "outline"
  size?: "default" | "sm" | "lg"
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant = "default", size = "default", ...props }, ref) => {
    return (
      <button
        className={cn(
          "inline-flex items-center justify-center rounded-md font-medium transition-colors",
          "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2",
          "disabled:opacity-50 disabled:cursor-not-allowed",
          {
            "default": "bg-geo-primary text-white hover:bg-blue-600 dark:hover:bg-blue-700",
            "secondary": "bg-slate-200 text-slate-900 hover:bg-slate-300 dark:bg-slate-800 dark:text-slate-50 dark:hover:bg-slate-700",
            "ghost": "hover:bg-slate-100 dark:hover:bg-slate-800",
            "outline": "border border-slate-300 dark:border-slate-600 hover:bg-slate-50 dark:hover:bg-slate-900"
          }[variant],
          {
            "default": "h-10 px-4 py-2",
            "sm": "h-9 rounded-md px-3 text-sm",
            "lg": "h-11 rounded-md px-8"
          }[size],
          className
        )}
        ref={ref}
        {...props}
      />
    )
  }
)
Button.displayName = "Button"

export { Button }
