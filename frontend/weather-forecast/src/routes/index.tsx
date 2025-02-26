import {RouterProvider, createBrowserRouter} from 'react-router-dom'
import { Home } from '../pages'
import { useAuth } from '../providers/AuthProvider';
import { ProtectedRoutes } from './ProtectedRoutes';

const Routes = () => {

  //@ts-ignore
  const { token } = useAuth();

  const publicRoutes = [
    {
      path: '/',
      element: <Home />
    },
    {
      path: '/about',
      element: <div>About</div>
    }
  ];

  const privateRoutes: any = [
    {
      path: '/',
      element: <ProtectedRoutes />,
      children: [
        {
          path: '/dashboard',
          element: <div>Dashboard</div>
        },
        {
          path: '/profile/:id',
          element: <div>Profile</div>
        }
      ]
    }
  ];

  const routesForNotAuthenticated = [
    {
      path: '/login',
      element: <div>Login</div>
    },
    {
      path: '/signup',
      element: <div>Signup</div>
    },
    {
      path: '*',
      element: <div>Page not found</div>
    }
  ];

  const router = createBrowserRouter([
    ...publicRoutes,
    ...(!token ? routesForNotAuthenticated : []),
    ...privateRoutes
  ]);

  return (
    <RouterProvider router={router} />
  )
};

export default Routes
