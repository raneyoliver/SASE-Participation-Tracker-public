import * as React from 'react';
import {
  Card, CardHeader, CardContent, Box,
} from '@material-ui/core';
import { SASEBlue } from '../../theme';

interface CardWithHeaderProps {
  title: string;
  action?: JSX.Element;
}

const CardWithHeader: React.FC<CardWithHeaderProps> = ({ title, action, children }) => (
  <Card>
    <Box bgcolor={SASEBlue} color="white">
      <CardHeader title={title} action={action} />
    </Box>
    <CardContent>
      {children}
    </CardContent>
  </Card>
);

export default CardWithHeader;
