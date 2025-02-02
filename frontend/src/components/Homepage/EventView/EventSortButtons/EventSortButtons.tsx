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
import { EventType } from '../../../../Enums';

interface EventSortButtonsProps {
  events: SerializedEvent[];
  variant: 'calendar' | 'cards';
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

const eventTypes = Object.values(EventType);

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
const EventSortButtons: React.FC<EventSortButtonsProps> = ({ events, variant, onSort }) => {
  // Keep initial order of events so that it can be reverted when not sorting or filtering
  const [initialEvents] = React.useState(events);
  const [filteredEvents, setFilteredEvents] = React.useState(events);

  // Default sort is by date chronologically
  const [dateSortDirection, setDateSortDirection] = React.useState(SortDirection.Ascending);

  // Default date filter is to show only upcoming events
  const [dateFilter, setDateFilter] = React.useState(DateFilter.Upcoming);

  // Default event type filter is to show all events (when no types are selected, all will show up)
  const [selectedEventTypes, setSelectedEventTypes] = React.useState(new Set());

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

  const eventTypeFilterButtons = eventTypes.map((eventType) => {
    // Either add or remove from selected types on click
    const selected = selectedEventTypes.has(eventType);
    const handleClick = selected ? (): void => {
      const newSelectedEventTypes = new Set(selectedEventTypes);
      newSelectedEventTypes.delete(eventType);
      setSelectedEventTypes(newSelectedEventTypes);
    } : (): void => {
      setSelectedEventTypes(new Set(selectedEventTypes).add(eventType));
    };

    return (
      <Button variant={selected ? 'contained' : null} onClick={handleClick} key={eventType}>
        {eventType}
      </Button>
    );
  });

  // Set filtered events when filters change
  React.useEffect(() => {
    let newEvents = [...initialEvents];

    // Apply date filter if this variant uses it
    if (variant === 'cards') {
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
    }

    // Apply event type filter
    if (selectedEventTypes.size) {
      newEvents = newEvents.filter((event) => selectedEventTypes.has(event.event_type));
    }

    setFilteredEvents(newEvents);
  }, [initialEvents, dateFilter, selectedEventTypes, variant]);

  const dateSortButton = variant === 'cards' ? (
    <Box display="flex" alignItems="center" marginBottom={1}>
      <Box marginRight={1}>
        <Typography>
          Sort By:
        </Typography>
      </Box>
      <Button
        id="sort-by-date"
        variant="contained"
        color="secondary"
        size="small"
        onClick={handleDateSortClick}
        endIcon={dateSortIcon}
      >
        Date
      </Button>
    </Box>
  ) : null;

  const dateFilterButtonGroup = variant === 'cards' ? (
    <Box display="flex" alignItems="center" marginBottom={1}>
      <Box marginRight={1}>
        <Typography>
          Date Filter:
        </Typography>
      </Box>
      <ButtonGroup color="secondary" size="small">
        {dateFilterButtons}
      </ButtonGroup>
    </Box>
  ) : null;

  return (
    <>
      {dateSortButton}
      {dateFilterButtonGroup}
      <Box display="flex" alignItems="center" marginBottom={1}>
        <Box marginRight={1}>
          <Typography>
            Event Types:
          </Typography>
        </Box>
        <ButtonGroup color="secondary" size="small">
          {eventTypeFilterButtons}
        </ButtonGroup>
      </Box>
    </>
  );
};

export default EventSortButtons;
