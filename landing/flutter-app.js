class FlutterApp extends HTMLElement {
  constructor() {
    super();
    const width = this.getAttribute("width") || "100%";
    const height = this.getAttribute("height") || "100%";
    this.innerHTML = `
  <style>
      #iframe-container {
        height: ${height};
        width: ${width};
        background-color: grey;
        margin: 0 0;
        border: none;
      }
    </style>
  <iframe 
      id="iframe-container"
      src="https://vancouver-art-compass.web.app/dashboard/home">
  </iframe>
      `;
  }
}

customElements.define("flutter-app", FlutterApp);
