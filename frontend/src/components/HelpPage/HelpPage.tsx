import * as React from 'react';
import {
  Typography, Box, Grid, List, ListItem, ListItemText,
} from '@material-ui/core';
import { RouteComponentProps } from '@reach/router';
import CardWithHeader from '../CardWithHeader/CardWithHeader';

const HelpPage: React.FC<RouteComponentProps> = () => (
  <>
    <Box textAlign="center" marginTop={3} padding={2}>
      <Typography variant="h4">
        Help Page
      </Typography>
    </Box>
    <Box padding={10}>
      <Grid container spacing={10}>
        <Grid item xs={6}>
          <CardWithHeader title="FAQ">
            <List>
              <ListItem>
                <ListItemText
                  primary="question"
                  secondary="answer"
                />
              </ListItem>
              <ListItem>
                <ListItemText
                  primary="question"
                  secondary="answer"
                />
              </ListItem>
              <ListItem>
                <ListItemText
                  primary="question"
                  secondary="answer"
                />
              </ListItem>
              <ListItem>
                <ListItemText
                  primary="question"
                  secondary="answer"
                />
              </ListItem>
            </List>
          </CardWithHeader>
        </Grid>
        <Grid item xs={6}>
          <CardWithHeader title="FAQ">
            <Typography variant="body1">
              test
            </Typography>
          </CardWithHeader>
        </Grid>
        <Grid item xs={6}>
          <CardWithHeader title="FAQ">
            <Typography variant="body1">
              test
            </Typography>
          </CardWithHeader>
        </Grid>
        <Grid item xs={6}>
          <CardWithHeader title="FAQ">
            <Typography variant="body1">
              test
            </Typography>
          </CardWithHeader>
        </Grid>
      </Grid>
    </Box>
  </>
);

export default HelpPage;
