import * as React from 'react';
import {
  Card, CardHeader, CardContent, Box,
} from '@material-ui/core';
import { SASEBlue } from '../../theme';

interface CardWithHeaderProps {
  title: string;
}

const CardWithHeader: React.FC<CardWithHeaderProps> = ({ title, children }) => (
  <Card>
    <Box bgcolor={SASEBlue} color="white">
      <CardHeader title={title} />
    </Box>
    <CardContent>
      {children}
    </CardContent>
  </Card>
);

export default CardWithHeader;
