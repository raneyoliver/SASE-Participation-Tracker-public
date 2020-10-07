import * as React from 'react';
import { navigate } from '@reach/router';
import IconButton from '@material-ui/core/IconButton';
import Menu from '@material-ui/core/Menu';
import MenuItem from '@material-ui/core/MenuItem';
import MoreVertIcon from '@material-ui/icons/MoreVert';
import { SerializedEvent } from '../../../../../types/Event';
import getCSRFToken from '../../../../../utils/getCSRFToken';
import DeleteConfirmationDialog from './DeleteConfirmationDialog/DeleteConfirmationDialog';

interface EventCardMenuProps {
  event: SerializedEvent;
}

const EventCardMenu: React.FC<EventCardMenuProps> = ({ event }) => {
  const [anchorEl, setAnchorEl] = React.useState(null);

  const handleClick = (mouseEvent: React.MouseEvent): void => {
    setAnchorEl(mouseEvent.currentTarget);
  };

  const handleClose = (): void => {
    setAnchorEl(null);
  };

  const handleEdit = (): void => {
    window.location.href = `/edit_event/${event.id}`;
  };

  const handleCreateRSVP = (): void => {
    const body = {
      id: event.id,
      form_type: 'RSVP',
    };

    fetch('/api/events/add_form', {
      method: 'POST',
      headers: {
        'Content-type': 'application/json',
        'X-CSRF-Token': getCSRFToken(),
      },
      body: JSON.stringify(body),
    }).then((response) => {
      if (response.ok) {
        window.location.reload();
      } else {
        navigate('/login');
      }
    });

    handleClose();
  };

  // handles dialog and api call for deleting an event
  const [deleteOpen, setDeleteOpen] = React.useState(false);

  const handleDeleteClickOpen = (): void => {
    setDeleteOpen(true);
    handleClose();
  };

  const handleDeleteClickClose = (): void => {
    setDeleteOpen(false);
  };

  const handleDelete = (): void => {
    const body = {
      id: event.id,
    };

    fetch('/api/events/delete', {
      method: 'POST',
      headers: {
        'Content-type': 'application/json',
        'X-CSRF-Token': getCSRFToken(),
      },
      body: JSON.stringify(body),
    }).then((response) => {
      if (response.status === 204) {
        window.location.reload();
      } else {
        navigate('/login');
      }
    });
  };

  const menuOptions: Record<string, () => any> = {
    'Edit Event': handleEdit,
    'Delete Event': handleDeleteClickOpen,
  };

  const hasRSVPForm = event.forms.some((form) => form.form_type.toString() === 'RSVP');

  if (!hasRSVPForm) {
    menuOptions['Create RSVP Form'] = handleCreateRSVP;
  }

  const menuItems = Object.entries(menuOptions).map(([key, value]) => (
    <MenuItem key={key} onClick={value}>
      {key}
    </MenuItem>
  ));

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
      <DeleteConfirmationDialog
        deleteOpen={deleteOpen}
        handleDeleteClickClose={handleDeleteClickClose}
        handleDelete={handleDelete}
      />
    </div>
  );
};

export default EventCardMenu;
