import * as React from 'react';
import IconButton from '@material-ui/core/IconButton';
import Menu from '@material-ui/core/Menu';
import MenuItem from '@material-ui/core/MenuItem';
import MoreVertIcon from '@material-ui/icons/MoreVert';

interface EventCardMenuProps {
    eventId: number;
    doesRSVPFormExist: boolean;
  }
const initialMenuOptions = {
  'Edit Event': 'put edit url here',
  'Delete Event': 'put delete url here',
};

const EventCardMenu: React.FC<EventCardMenuProps> = ({ eventId, doesRSVPFormExist }) => {
  const [anchorEl, setAnchorEl] = React.useState(null);
  const [menuOptions, setMenuOptions] = React.useState(initialMenuOptions);
  React.useEffect(() => {
    const newOptions = { ...menuOptions };
    if (doesRSVPFormExist) {
      if (!('Create RSVP Form' in newOptions)) {
        Object.assign(newOptions, { 'Create RSVP Form': 'put create rsvp url here' });
        setMenuOptions(newOptions);
      }
    } else if ('Create RSVP Form' in newOptions) {
      delete newOptions['Create RSVP Form'];
      setMenuOptions(newOptions);
    }
  }, [doesRSVPFormExist, menuOptions]);

  const handleClick = (event: React.MouseEvent): void => {
    setAnchorEl(event.currentTarget);
  };

  const handleClose = (): void => {
    setAnchorEl(null);
  };

  return (
    <div>
      <IconButton
        id="event-menu-button"
        aria-label="event-menu-icon"
        aria-controls="event-menu"
        aria-haspopup="true"
        onClick={handleClick}
        style={{ color: 'white' }}
      >
        <MoreVertIcon />
      </IconButton>
      <Menu
        id="event-menu"
        anchorEl={anchorEl}
        keepMounted
        open={Boolean(anchorEl)}
        onClose={handleClose}
      >
        {Object.entries(menuOptions).map(([key, value]) => (
          <MenuItem key={key} onClick={handleClose}>
            {key}
          </MenuItem>
        ))}
      </Menu>
    </div>
  );
};

export default EventCardMenu;
