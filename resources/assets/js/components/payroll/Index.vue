<template>  
  <div id="app">
    <div class="ibox " >
      <div class="ibox-title">
        <h5>Lista de Empleados ({{ total }})</h5>
        <div class="ibox-tools">
          <a class="collapse-link">
            <i class="fa fa-chevron-up"></i>
          </a>
        </div>
      </div>
      <div class="ibox-content">
        <div class="" id="parent">
          <div class="box">
            <vue-scrolling-table
              :scroll-horizontal="scrollHorizontal"
              :scroll-vertical="scrollVertical"
              :sync-header-scroll="syncHeaderScroll"
              :sync-footer-scroll="syncFooterScroll"
              :dead-area-color="deadAreaColor"
              :class="{ freezeFirstColumn:freezeFirstColumn }" class="table table-striped table-bordered table-hover">
              <template slot="thead">
                <tr>
                  <th>N°</th>
                  <th>Trabajador</th>
                  <th>Días Trabajados</th>
                  <th>Dias NO Trabajados</th>
                  <th>RC-IVA 13%</th>
                  <th>Descuentos</th>
                  <th>Saldo Tributario</th>
                  <!-- <th>Cuenta Bancaria</th>
                  <th>Fecha de Nacimiento</th> -->
                  <th>Liquido Pagable</th>
                  <th>Total descuentos</th>
                  <th>Inicio Contrato</th>
                  <th>Fin Contrato</th>
                  <!-- <th>Haber básico</th> -->
                  <!-- <th>Total Ganado</th> -->
                  <!-- <th>Puesto</th> -->
                  <!-- <th class="chargeCol">Cargo</th> -->
                  <!-- <th>AFP</th> -->
                  <!-- <th>Desc. Renta vejez 10%</th>
                  <th>Desc. Riesgo común 1,71%</th>
                  <th>Desc. Comisión 0,5%</th>
                  <th>Desc. Aporte solidario 0,5%</th>
                  <th>Desc. Aporte Nacional Solidario 1%</th>
                  <th>Total descuentos de ley</th>
                  <th>Sueldo Neto</th> -->
                </tr>
              </template>
              <template slot="tbody">
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
              </template>
              <template slot="tfoot">
                
              </template>
            </vue-scrolling-table>
          </div>

        </div>
      </div>
    </div>
  </div>
</template>
<script>
import row from "./row.vue";
import EditRow from "./EditRow.vue";
import VueScrollingTable from "vue-scrolling-table"

export default {
  props: ["edit", "procedure"],
  components: {
    VueScrollingTable,
    row,
    EditRow
  },
  data: function() {
    return {
      total: 0,
      contracts: [],
      payrolls: [],

      scrollVertical: true,
      scrollHorizontal: true,
      syncHeaderScroll: true,
      syncFooterScroll: true,
      includeFooter: true,
      deadAreaColor: "#DDDDDD",
      maxRows: 100,
      freezeFirstColumn: true,
      
    }
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
          this.allItems = response.data.payrolls;
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
          this.allItems = response.data.contracts;
        })
        .catch(error => {
          console.log(error);
        });
    }
  },
  computed: {
    items() {
      return this.allItems.slice(0, this.maxRows)
    },
  },
}
</script>
<style>
table.scrolling .w2 {
  width: 20em;
  min-width: 20em;
  max-width: 20em;
}
table.scrolling tfoot tr th {
  width: 130em;
  min-width: 130em;
  max-width: 130em;
}
table.freezeFirstColumn thead tr,
table.freezeFirstColumn tbody tr {
  display: block;
  width: min-content;
}
table.freezeFirstColumn thead td:first-child,
table.freezeFirstColumn tbody td:first-child,
table.freezeFirstColumn thead th:first-child,
table.freezeFirstColumn tbody th:first-child {
  position: sticky;
  position: -webkit-sticky;
  left: 0;
  box-shadow: 0 0 2px -1px slategray;
  width: 40px;
  min-width: 40px;
  max-width: 40px;
}
table.freezeFirstColumn thead td:nth-child(2),
table.freezeFirstColumn tbody td:nth-child(2),
table.freezeFirstColumn thead th:nth-child(2),
table.freezeFirstColumn tbody th:nth-child(2) {
  position: sticky;
  position: -webkit-sticky;
  left: 40px;
  width: 160px;
  min-width: 160px;
  max-width: 160px;
  box-shadow: 3px 0 2px -1px slategray;
}
* {
  font-family: sans-serif;
}
.box {
  clear: both;
  padding: 0;
  min-height: 550px;
  height: 55vh;
  margin-left: auto;
  margin-right: auto;
  overflow: hidden;
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

  table tbody tr .chargeCol,
  table thead tr .chargeCol {
    width: 350px;
    min-width: 350px;
    max-width: 350px;
  }
</style>