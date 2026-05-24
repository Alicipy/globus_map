(() => {
  const { Deck, TileLayer, BitmapLayer, JSONConverter, JSONConfiguration } = deck;

  const TOOLTIP_RENDERERS = {
    communities: (o) =>
      `Community: ${o.community}\n` +
      `Next: ${o.name}\n` +
      `Distance: ${o.distance_km_fmt} km`,
    globus: (o) =>
      `Name: ${o.name}\n` +
      `Location: ${o.location}\n` +
      `Coordinates: (${o.lat_fmt}, ${o.lon_fmt})`,
  };

  function getTooltip({ object, layer }) {
    if (!object || !layer) return null;
    const render = TOOLTIP_RENDERERS[layer.id];
    if (!render) return null;
    return { className: "deck-tooltip", text: render(object) };
  }

  const basemap = new TileLayer({
    id: "carto-light-basemap",
    data: "https://basemaps.cartocdn.com/light_all/{z}/{x}/{y}@2x.png",
    minZoom: 0,
    maxZoom: 19,
    tileSize: 256,
    renderSubLayers: (props) => {
      const [[west, south], [east, north]] = props.tile.boundingBox;
      return new BitmapLayer(props, {
        data: null,
        image: props.data,
        bounds: [west, south, east, north],
      });
    },
  });

  const converter = new JSONConverter({
    configuration: new JSONConfiguration({ classes: deck }),
  });

  const loadingEl = document.getElementById("loading");

  fetch("/data/processed/deck.json")
    .then((r) => {
      if (!r.ok) throw new Error(`deck.json ${r.status}`);
      return r.json();
    })
    .then((spec) => {
      const props = converter.convert(spec);
      delete props.mapStyle;
      new Deck({
        parent: document.getElementById("deck-container"),
        ...props,
        layers: [basemap, ...(props.layers || [])],
        getTooltip,
      });
      loadingEl.classList.add("is-hidden");
    })
    .catch((err) => {
      loadingEl.textContent = `Failed to load map: ${err.message}`;
    });

  const tabs = document.querySelectorAll(".tab");
  const panels = document.querySelectorAll(".tab-panel");
  tabs.forEach((tab) => {
    tab.addEventListener("click", () => {
      const target = tab.dataset.tab;
      tabs.forEach((t) => {
        const active = t.dataset.tab === target;
        t.classList.toggle("is-active", active);
        t.setAttribute("aria-selected", active ? "true" : "false");
      });
      panels.forEach((p) => {
        p.hidden = p.id !== `tab-${target}`;
      });
    });
  });
})();
