import * as React from 'react';
import {
  Box, Button, SvgIcon, Typography,
} from '@material-ui/core';
import { ArrowDownward, ArrowUpward } from '@material-ui/icons';
import { EventWithID } from '../../../../types/Event';
import {
  sortEventsByTimeAscending, sortEventsByTimeDescending,
} from '../../../../utils/sortEvents';

interface EventSortButtonsProps {
  events: EventWithID[];
  onSort: (events: EventWithID[]) => any;
}

enum SortDirection {
  Ascending,
  Descending,
  // If a different sort method is being used, SortDirection should be NotSorting
  NotSorting,
}

function getNextSortDirection(currentDirection: SortDirection): SortDirection {
  switch (currentDirection) {
    case SortDirection.NotSorting: return SortDirection.Ascending;
    case SortDirection.Ascending: return SortDirection.Descending;
    case SortDirection.Descending: return SortDirection.NotSorting;
    default: return SortDirection.NotSorting;
  }
}

/* eslint-disable react/jsx-key */
const sortDirectionIcons = new Map<SortDirection, JSX.Element>([
  // If not sorting, create invisible icon to take up space
  [SortDirection.NotSorting, <SvgIcon />],
  [SortDirection.Ascending, <ArrowUpward />],
  [SortDirection.Descending, <ArrowDownward />],
]);
/* eslint-enable react/jsx-key */

// If we decide to add other sorting methods, we can put them in this component
const EventSortButtons: React.FC<EventSortButtonsProps> = ({ events, onSort }) => {
  // Keep initial order of events so that it can be reverted when not sorting
  const [initialEvents, setInitialEvents] = React.useState(events);
  const [dateSortDirection, setDateSortDirection] = React.useState(SortDirection.NotSorting);

  const dateSortIcon = sortDirectionIcons.get(dateSortDirection);

  const handleDateSortClick = (): void => {
    // Determine new sort direction
    const newSortDirection = getNextSortDirection(dateSortDirection);
    setDateSortDirection(newSortDirection);

    // Sort events based on new direction and use callback from parent component
    const newEvents = [...initialEvents];
    switch (newSortDirection) {
      case (SortDirection.Ascending): {
        sortEventsByTimeAscending(newEvents);
        break;
      }
      case (SortDirection.Descending): {
        sortEventsByTimeDescending(newEvents);
        break;
      }
      default: break;
    }

    onSort(newEvents);
  };

  return (
    <Box display="flex" alignItems="center">
      <Box marginRight={1}>
        <Typography>
          Sort By:
        </Typography>
      </Box>
      <Button variant="contained" color="secondary" onClick={handleDateSortClick} endIcon={dateSortIcon}>
        Date
      </Button>
    </Box>
  );
};

export default EventSortButtons;
