// Formats a Date object to a pretty string representation
export default function formatDate(date: Date): string {
  const minutes = String(date.getMinutes()).padStart(2, '0');
  return `${date.getMonth() + 1}/${date.getDate()}/${date.getFullYear()}, ${date.getHours()}:${minutes}`;
}
