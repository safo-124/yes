'use client';

import { Button } from '@/components/ui/button';
import Link from 'next/link';

export default function HomePage() {
 

  return (
    <div>
      <Button variant="destructive">
        <Link href="/home">
          to the homepage
        </Link>
        
      </Button>
    
    </div>
  );
}
