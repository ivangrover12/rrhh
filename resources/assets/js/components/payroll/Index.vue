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
      <div class="ibox-content" style="height:600px">
        <div class="" id="parent">
          <div class="box">
            <vue-scrolling-table
              :scroll-horizontal="scrollHorizontal"
              :scroll-vertical="scrollVertical"
              :sync-header-scroll="syncHeaderScroll"
              :sync-footer-scroll="syncFooterScroll"
              :include-footer="includeFooter"
              :dead-area-color="deadAreaColor"
              :class="{ freezeFirstColumn:freezeFirstColumn }" class="table table-striped table-bordered table-hover zui-table">
              <template slot="thead">
                <tr>
                  <th class="first-column">C.I.</th>
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
}
table.freezeFirstColumn thead td:nth-child(2),
table.freezeFirstColumn tbody td:nth-child(2),
table.freezeFirstColumn thead th:nth-child(2),
table.freezeFirstColumn tbody th:nth-child(2) {
  position: sticky;
  position: -webkit-sticky;
  left: 130px;
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
</style>