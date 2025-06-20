export default function HomePage() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24 bg-gray-100 text-gray-800">
      <h1 className="text-5xl font-bold mb-6 text-primary">
        Welcome to the Lecturer Claims System
      </h1>
      <p className="text-lg text-secondary mb-8 text-center max-w-2xl">
        Your comprehensive platform for managing lecturer claims, academic programs, and course offerings.
      </p>
      <div className="flex gap-4">
        {/* Placeholder links for login/signup - these will become actual links later */}
        <a
          href="/login"
          className="px-6 py-3 bg-primary text-white rounded-lg shadow-md hover:bg-primary-dark transition duration-300 ease-in-out"
        >
          Login
        </a>
        <a
          href="/signup"
          className="px-6 py-3 border border-primary text-primary rounded-lg shadow-md hover:bg-primary-light hover:text-white transition duration-300 ease-in-out"
        >
          Sign Up
        </a>
      </div>
    </main>
  );
}
