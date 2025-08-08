<div class="top-bar">
  <div class="container-fluid">
    <div class="row no-gutters">
      <div class="col-md-4 col-6">
        <p id="datetime"></p>
      </div>
    </div>
  </div>
</div>

<div class="header-middle">
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-8">
        <div class="logo">
          <img src="${pageContext.request.contextPath}/images/tg.png" alt="sec logo">
          <h1 style="padding: 0px; font-size: 15px !important; font-weight: 600; color:#1aa693;margin-left: 30px;">
            Ticketing System
          </h1>
          <h3 style="font-size: 15px !important; color:#1aa693;">Telangana State Election Commission <br>
            <p style="color: rgba(0, 0, 0, 0.571);">Government of Telangana</p>
          </h3>


        </div>
      </div>
      <!-- <div class=" top-bar col-md-4 text-right col-6" >
        <button id="btn-decrease" style="padding: 3px;">A-</button>
        <button id="btn-orig" style="padding: 3px; padding-left: 5px; padding-right: 5px;">A</button>
        <button id="btn-increase" style="padding: 3px;">A+</button>
      </div> -->
    </div>
  </div>
</div>

<script>
  let baseFontSize = 0.7; // Default font size in rem

  function updateFontSize() {
    document.documentElement.style.setProperty("--base-font-size", baseFontSize + "rem", "important");
    document.querySelectorAll("*").forEach(el => {
      el.style.fontSize = baseFontSize + "rem !important";
    });
  }

  document.getElementById("btn-increase").addEventListener("click", function () {
    baseFontSize += 0.1; // Increase font size
    updateFontSize();
  });

  document.getElementById("btn-decrease").addEventListener("click", function () {
    // if (baseFontSize > 0.1) { // Prevent it from getting too small
    baseFontSize -= 0.1;
    updateFontSize();
    // }
  });

  document.getElementById("btn-orig").addEventListener("click", function () {
    baseFontSize = 0.7; // Reset to default
    updateFontSize();
  });
</script>