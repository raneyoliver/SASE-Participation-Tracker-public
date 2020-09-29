import * as React from 'react';
import {
  Box, Button, ButtonGroup, SvgIcon, Typography,
} from '@material-ui/core';
import { ArrowDownward, ArrowUpward } from '@material-ui/icons';
import { SerializedEvent } from '../../../../types/Event';
import {
  sortEventsByTimeAscending, sortEventsByTimeDescending,
} from '../../../../utils/sortEvents';
import { filterEventsOnlyPast, filterEventsOnlyUpcoming } from '../../../../utils/filterEvents';

interface EventSortButtonsProps {
  events: SerializedEvent[];
  onSort: (events: SerializedEvent[]) => any;
}

enum SortDirection {
  Ascending,
  Descending,
  // If a different sort method is being used, SortDirection should be NotSorting
  NotSorting,
}

enum DateFilter {
  All = 'All',
  Past = 'Past',
  Upcoming = 'Upcoming',
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

const dateSortKeys = [DateFilter.All, DateFilter.Past, DateFilter.Upcoming];

// If we decide to add other sorting methods, we can put them in this component
const EventSortButtons: React.FC<EventSortButtonsProps> = ({ events, onSort }) => {
  // Keep initial order of events so that it can be reverted when not sorting or filtering
  const [initialEvents] = React.useState(events);
  const [filteredEvents, setFilteredEvents] = React.useState(events);

  // Default sort is by date chronologically
  const [dateSortDirection, setDateSortDirection] = React.useState(SortDirection.Ascending);

  // Default date filter is to show all events
  const [dateFilter, setDateFilter] = React.useState(DateFilter.All);

  // When sort button is clicked or filters are changed, resort events
  React.useEffect(() => {
    // Sort events based on new direction and use callback from parent component
    const newEvents = [...filteredEvents];
    switch (dateSortDirection) {
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
  }, [dateSortDirection, filteredEvents, onSort]);

  const dateSortIcon = sortDirectionIcons.get(dateSortDirection);

  const dateFilterButtons = dateSortKeys.map((filter) => {
    const handleClick = (): void => { setDateFilter(filter); };

    return (
      <Button variant={filter === dateFilter ? 'contained' : null} onClick={handleClick} key={filter}>
        {filter}
      </Button>
    );
  });

  const handleDateSortClick = (): void => {
    setDateSortDirection(getNextSortDirection(dateSortDirection));
  };

  // Set filtered events when date filter changes
  React.useEffect(() => {
    let newEvents = [...initialEvents];
    switch (dateFilter) {
      case (DateFilter.Past): {
        newEvents = filterEventsOnlyPast(newEvents);
        break;
      }
      case (DateFilter.Upcoming): {
        newEvents = filterEventsOnlyUpcoming(newEvents);
        break;
      }
      // DateFilter.All: newEvents already includes all events, so do nothing
      default: break;
    }

    setFilteredEvents(newEvents);
  }, [initialEvents, dateFilter]);

  return (
    <>
      <Box display="flex" alignItems="center" marginBottom={1}>
        <Box marginRight={1}>
          <Typography>
            Sort By:
          </Typography>
        </Box>
        <Button id="sort-by-date" variant="contained" color="secondary" onClick={handleDateSortClick} endIcon={dateSortIcon}>
          Date
        </Button>
      </Box>
      <Box display="flex" alignItems="center">
        <Box marginRight={1}>
          <Typography>
            Date Filter:
          </Typography>
        </Box>
        <ButtonGroup color="primary" size="small">
          {dateFilterButtons}
        </ButtonGroup>
      </Box>
    </>
  );
};

export default EventSortButtons;
