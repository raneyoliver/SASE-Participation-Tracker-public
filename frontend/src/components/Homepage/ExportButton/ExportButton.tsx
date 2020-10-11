import * as React from 'react';
import {
  Button,
} from '@material-ui/core';
import { CSVLink } from 'react-csv';

interface ExportButtonProps {
  id: string;
}

const ExportButton: React.FC<ExportButtonProps> = () => {
  const [csvData, setCSVData] = React.useState([]);

  React.useEffect(() => {
    fetch('api/events/export').then((response) => response.json()).then((response) => setCSVData(response));
  }, []);

  return (
    <Button id="download" color="secondary">
      <CSVLink
        data={csvData}
        filename="SASE-user-data.csv"
        className="btn btn-primary"
        target="_blank"
        style={{ textDecoration: 'none', color: 'inherit' }}
      >
        Export Data
      </CSVLink>
    </Button>
  );
};

export default ExportButton;
