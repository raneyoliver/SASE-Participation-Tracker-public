import * as React from 'react';
import {
  Card, CardHeader, CardContent, Box,
} from '@material-ui/core';
import { SASEBlue } from '../../theme';

interface CardWithHeaderProps {
  title: string;
  action?: JSX.Element;
  id?: string;
  icon?: JSX.Element;
  fixedWidth?: boolean;
}

function displayWidth(fixedWidth: boolean): string {
  if (window.innerWidth >= 1000 && fixedWidth === true) {
    return '50%';
  }
  return '90%';
}

const CardWithHeader: React.FC<CardWithHeaderProps> = ({
  title, action, id, icon, fixedWidth, children,
}) => (
  <Box margin="auto" width={displayWidth(fixedWidth)} paddingTop={1}>
    <Card id={id}>
      <Box display="flex" justifyContent="space-between" alignItems="center" bgcolor={SASEBlue} color="white">
        <CardHeader title={title} action={action} />
        {icon}
      </Box>
      <CardContent>
        {children}
      </CardContent>
    </Card>
  </Box>
);

export default CardWithHeader;
