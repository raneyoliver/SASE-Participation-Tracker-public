import * as React from 'react';
import IconButton from '@material-ui/core/IconButton';
import Menu from '@material-ui/core/Menu';
import MenuItem from '@material-ui/core/MenuItem';
import MoreVertIcon from '@material-ui/icons/MoreVert';
import { SerializedEvent } from '../../../../../types/Event';
import FormType from '../../../../../Enums';

interface EventCardMenuProps {
    event: SerializedEvent;
  }

const EventCardMenu: React.FC<EventCardMenuProps> = ({ event }) => {
  const [anchorEl, setAnchorEl] = React.useState(null);

  const menuOptions = {
    'Edit Event': 'put edit url here',
    'Delete Event': 'put delete url here',
  };
  const hasRSVPForm = event.forms.some((form) => form.form_type === FormType.RSVP)
  if (!hasRSVPForm) {
    Object.assign(menuOptions, { 'Create RSVP Form': 'put create rsvp url here' });
  }

  const handleClick = (event: React.MouseEvent): void => {
    setAnchorEl(event.currentTarget);
  };

  const handleClose = (): void => {
    setAnchorEl(null);
  };

  const menuItems = Object.entries(menuOptions).map(([key, value]) => (
    <MenuItem key={key} onClick={handleClose}>
      {key}
    </MenuItem>
  ))

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
      {menuItems}
      </Menu>
    </div>
  );
};

export default EventCardMenu;
