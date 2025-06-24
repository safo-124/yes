import React from 'react';
import { cva } from 'class-variance-authority';
import { cn } from '@/lib/utils'; // Ensure '@/lib/utils' resolves correctly via jsconfig.json

const buttonVariants = cva(
  "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50",
  {
    variants: {
      variant: {
        // Shadcn defaults. Colors will be picked up from globals.css HSL vars.
        default: "bg-primary text-primary-foreground shadow hover:bg-primary/90",
        destructive: "bg-destructive text-destructive-foreground shadow-sm hover:bg-destructive/90",
        outline: "border border-input bg-background shadow-sm hover:bg-accent hover:text-accent-foreground",
        secondary: "bg-secondary text-secondary-foreground shadow-sm hover:bg-secondary/90",
        ghost: "hover:bg-accent hover:text-accent-foreground",
        link: "text-primary underline-offset-4 hover:underline",
      },
      size: {
        default: "h-9 px-4 py-2",
        sm: "h-8 rounded-md px-3 text-xs",
        lg: "h-10 rounded-md px-8",
        icon: "h-9 w-9",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
);

const Button = React.forwardRef(
  ({ className, variant, size, asChild = false, ...props }, ref) => {
    const finalClassName = cn(buttonVariants({ variant, size, className }));

    // If asChild is true, clone the child and pass the generated classes and ref to it.
    // This is the common pattern for Shadcn to allow flexibility with rendered elements (e.g., <a>, <Link>).
    if (asChild && React.isValidElement(props.children)) {
      return React.cloneElement(props.children, {
        className: cn(props.children.props.className, finalClassName), // Merge existing and generated classes
        ref: ref,
        ...props, // Pass other props like onClick, type etc.
      });
    }

    // Default behavior: render a <button> element
    return (
      <button
        className={finalClassName}
        ref={ref}
        {...props}
      />
    );
  }
);
Button.displayName = "Button";

// Ensure Button is correctly exported as a named export
export { Button, buttonVariants };
