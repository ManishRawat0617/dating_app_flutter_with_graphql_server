import { createServer } from '@graphql-yoga/node';
import jwt from 'jsonwebtoken';

const server = createServer({
  context: ({ request }) => {
    const authHeader = request.headers.get('authorization') || '';
    const token = authHeader.replace('Bearer ', '');

    let user = null;
    if (token) {
      try {
        user = jwt.verify(token, process.env.JWT_SECRET); // e.g., { id, role, email }
      } catch (err) {
        console.warn('Invalid token:', err.message);
      }
    }

    return { user }; // Will be null if unauthenticated
  },
});
