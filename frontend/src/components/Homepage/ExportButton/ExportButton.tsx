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

  function fetchData(): void {
    fetch('api/events/export').then((response) => response.json()).then((response) => JSON.parse(response)).then((response) => setCSVData(response));
  }

  React.useEffect(() => {
    fetchData();
  });

  return (
    <Button id="download" variant="contained" color="secondary">
      <CSVLink
        data={csvData}
        filename="my-file.csv"
        className="btn btn-primary"
        target="_blank"
      >
        Download
      </CSVLink>
    </Button>
  );
};

export default ExportButton;
