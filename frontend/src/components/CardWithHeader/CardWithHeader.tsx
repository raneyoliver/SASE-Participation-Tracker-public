import * as React from 'react';
import {
  Card, CardHeader, CardContent, Box,
} from '@material-ui/core';
import { isMobile } from 'react-device-detect';
import { SASEBlue } from '../../theme';

interface CardWithHeaderProps {
  title: string;
  action?: JSX.Element;
  id?: string;
  icon?: JSX.Element;
  fixWidth?: boolean;
}

function displayWidth(fixWidth: boolean): string {
  if (fixWidth) {
    return 'auto';
  }
  if (isMobile) {
    return '95%';
  }
  return '50%';
}

const CardWithHeader: React.FC<CardWithHeaderProps> = ({
  title, action, id, icon, fixWidth, children,
}) => (
  <Box margin="auto" paddingTop={1} width={displayWidth(fixWidth)}>
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
