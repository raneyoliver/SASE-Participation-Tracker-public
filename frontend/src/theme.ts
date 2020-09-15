import { createMuiTheme } from '@material-ui/core/styles';

export const SASEBlue = '#0f6cb6';
export const SASEGreen = '#8dc63f';

const palette = {
  primary: { main: SASEBlue, contrastText: '#fff' },
  secondary: { main: SASEGreen, contrastText: '#fff' },
};

export default createMuiTheme({ palette });
