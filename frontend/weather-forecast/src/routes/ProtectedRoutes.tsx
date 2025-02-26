import {Navigate, Outlet} from 'react-router-dom';
import {useAuth} from '../providers/AuthProvider';

export const ProtectedRoutes = () => {
  //@ts-ignore
  const { token } = useAuth();

  return (
    token? (
      <Outlet />
    ) : (
      <Navigate to='/login' />
    )
  )
};