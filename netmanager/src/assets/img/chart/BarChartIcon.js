import React from "react";

export const BarChartIcon = ({ className, style, width, onClick }) => {
  return (
    <svg
      className={className || ""}
      style={style || {}}
      xmlns="http://www.w3.org/2000/svg"
      height="24"
      viewBox="0 0 24 24"
      width={width || "24"}
      onClick={onClick}
    >
      <path d="M0 0h24v24H0z" fill="none" />
      <path d="M5 9.2h3V19H5zM10.6 5h2.8v14h-2.8zm5.6 8H19v6h-2.8z" />
    </svg>
  );
};
