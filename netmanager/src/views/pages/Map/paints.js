export const circlePointPaint = {
  // "circle-radius": [
  //   "interpolate",
  //   ["linear"],
  //   ["zoom"],
  //   9,
  //   7,
  //   10,
  //   14,
  //   11,
  //   28,
  //   12,
  //   56,
  //   13,
  //   112,
  //   14,
  //   224,
  //   15,
  //   448,
  //   16,
  //   896,
  //   17,
  //   1792,
  //   18,
  //   3584,
  //   19,
  //   9000,
  //   20,
  //   14336,
  //   21,
  //   28697,
  //   22,
  //   57344,
  // ],
  "circle-stroke-color": [
    "interpolate",
    ["linear"],
    ["get", "predicted_value"],
    0,
    "rgba(236,222,239,0)",
    0.001,
    "#28a013",
    10,
    "#28a013",
    14,
    "#cae401",
    33.4,
    "#dde401",
    37.4,
    "#bd600f",
    53.4,
    "#bd600f",
    60.4,
    "#b30018",
    145.4,
    "#b30018",
    155.4,
    "#b30018",
    245.4,
    "#b30018",
    260.4,
    "#990014",
    500.4,
    "#990014",
  ],
  "circle-radius": {
    property: "dbh",
    type: "exponential",
    stops: [
      [{ zoom: 15, value: 1 }, 5],
      [{ zoom: 15, value: 500 }, 10],
      [{ zoom: 22, value: 1 }, 20],
      [{ zoom: 22, value: 500 }, 50],
    ],
  },
  "circle-color": [
    "interpolate",
    ["linear"],
    ["get", "predicted_value"],
    0,
    "rgba(236,222,239,0)",
    0.001,
    "#44e527",
    10,
    "#44e527",
    14,
    "#e8fe39",
    33.4,
    "#f8fe39",
    37.4,
    "#ee8327",
    53.4,
    "#ee8327",
    60.4,
    "#fe0023",
    145.4,
    "#fe0023",
    155.4,
    "#8639c0",
    245.4,
    "#8639c0",
    260.4,
    "#81202e",
    500.4,
    "#81202e",
  ],
  "circle-stroke-width": 1,
  "circle-blur": [
    "interpolate",
    ["linear"],
    ["zoom"],
    0,
    0.1,
    9,
    1,
    17,
    1.5,
    49,
    2,
  ],
  "circle-opacity": {
    stops: [
      [14, 0],
      [15, 1],
    ],
  },
};

export const heatMapPaint = {
  "heatmap-weight": {
    property: "predicted_value",
    type: "exponential",
    stops: [
      [1, 0],
      [500, 1],
    ],
  },
  "heatmap-intensity": {
    stops: [
      [1, 1],
      [500, 3],
    ],
  },
  "heatmap-color": [
    "interpolate",
    ["linear"],
    ["heatmap-density"],
    0,
    "rgba(217, 217, 217,0)",
    0.2,
    "rgba(208,209,230,0.2)",
    0.4,
    "rgb(255, 230, 240)",
    0.6,
    "rgb(255, 230, 240)",
    0.8,
    "rgb(255, 179, 209)",
    1,
    "rgb(255, 204, 224)",
  ],
  "heatmap-radius": {
    stops: [
      [1, 12],
      [12, 18],
    ],
  },
  "heatmap-opacity": {
    default: 1,
    stops: [
      [14, 1],
      [15, 0],
    ],
  },
};
