<template>
  <div>
    <div class="ibox " >
      <div class="ibox-title">
        <h5>Lista de Empleados ({{ total }})</h5>
        <div class="ibox-tools">
          <a class="collapse-link">
            <i class="fa fa-chevron-up"></i>
          </a>
        </div>
      </div>
      <div class="ibox-content" style="height:600px">
        <div class="" id="parent">
          <table class="table table-striped table-bordered table-hover zui-table">
            <thead id="myhead">
              <tr>
                <th>C.I.</th>
                <th>Trabajador</th>
                <th>Cuenta Bancaria</th>
                <th>Fecha de Nacimiento</th>
                <th>Puesto</th>
                <th>Cargo</th>                
                <th># de dias Trabajados</th>
                <th>Haber basico</th>
                <th>Total Ganado</th>
                <th>AFP</th>
                <th>Descuento Renta vejez 10 %</th>
                <th>Descuento Riesgo común 1,71 %</th>
                <th>Descuento Comisión 0 ,5 %</th>
                <th>Descuento Aporte solidario del asegurado 0 ,5 %</th>
                <th>Descuento Aporte Nacional solidario 1 %</th>
                <th>Total descuentos de ley</th>
                <th>Sueldo Neto</th>
                <th>RC-IVA 13%</th>
                <th>Descuentos por Atrasos, Abandonos, Faltas y Licencia S/G Haberes</th>
                <th>Total descuentos</th>
                <th>Liquido Pagable</th>
              </tr>
            </thead>
            <tbody id="mybody" onscroll="document.getElementById('myhead').scrollLeft=document.getElementById('mybody').scrollLeft">

              <row v-for="(value, index) in contracts"
                   :key="`contract-${index}`"
                   :contract="value"
                   :cont="index"
                   :procedure="procedure"
                   v-if="!edit"></row>
              <edit-row v-for="(value, index) in payrolls"
                        :key="`payroll-${index}`"
                        :cont="index"
                        :payroll="value"
                        :procedure="procedure"
                        v-if="edit"></edit-row>
            </tbody>
          </table>
        </div>
        <div class="row">
          <div class="text-center">
            <br>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import row from "./row.vue";
  import EditRow from "./EditRow.vue";

  export default {
    props: ["edit", "procedure"],
    components: {
      row,
      EditRow
    },
    data() {
      return {
        total: 0,
        contracts: [],
        payrolls: []
      };
    },
    created() {
      if (this.edit) {
        axios
          .get("/api/payrolls", {
            params: {
              year: this.procedure.year,
              month: this.procedure.month.name
            }
          })
          .then(response => {
            this.payrolls = response.data.payrolls;
            this.total = response.data.total;
          })
          .catch(error => {
            console.log(error);
          });
      } else {
        axios
          .get("/api/contracts",{
            params:{
              year: this.procedure.year,
              month: this.procedure.month.name
            }
          })
          .then(response => {
            this.contracts = response.data.contracts;
            this.total = response.data.total;
          })
          .catch(error => {
            console.log(error);
          });
      }
    }
  };
  function fixscroll() {
  const thead = document.getElementById("myhead");
  const tbodyScroll = document.getElementById("mybody").scrollLeft;
  thead.scrollLeft = tbodyScroll;
  //document.getElementById("frozen").scrollLeft = 0;
}
</script>
<style>
#parent {
  position: absolute;
  left: 15px;
  top: 100px;
  width: 98%;
  height: 500px;
  overflow: hidden;
}

table {
  display: flex;
  flex-direction: column;
  flex: 1 1 auto;
  width: 100%;
  height: 100%;
  border-collapse: collapse;
  overflow: hidden;
}

thead {
  flex: 1 0 auto;
  display: block;
  overflow-x: hidden;
  overflow-y: scroll;
}
thead::-webkit-scrollbar { display: block;  }
thead::-webkit-scrollbar-track { }
tbody {
  display: block;
  overflow: scroll;
}
tbody:nth-child(3) { display: none; }

td, th {
  width: 400px;
  min-width: 400px;
  padding: 0;
}

th {
}

td:first-child,
th:first-child {
  position: sticky;
  position: -webkit-sticky;
  left:0;
  background: #fff;
}
td:nth-child(2),
th:nth-child(2) {
  position: sticky;
  position: -webkit-sticky;
  left:300px;
  background: #fff;
}




.zui-table {
    border: none;
    border-right: solid 1px #ddefef;
    border-collapse: separate;
    border-spacing: 0;
    font: normal 13px Arial, sans-serif;
  }
  .zui-table thead th {
    background-color: #ddefef;
    border: none;
    color: #336b6b;
    padding: 10px;
    text-align: left;
    text-shadow: 1px 1px 1px #fff;
    white-space: nowrap;

  }





  .zui-table td:hover::after,
  .zui-table th:hover::after {
    background-color: #ffa;
  }

  .zui-table td:focus::after,
  .zui-table th:focus::after {
    background-color: lightblue;
  }

  .zui-table td:focus::before,
  .zui-table tbody th:focus::before {
    background-color: lightblue;
    content: '';  
    height: 100%;
    top: 0;
    left: -5000px;
    position: absolute;  
    width: 10000px;
    z-index: -1;
  }
</style>
