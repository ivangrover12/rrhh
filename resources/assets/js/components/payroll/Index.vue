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
        <table id="payroll-table" class="table table-striped">
          <thead>
            <tr>
              <th>N°</th>
              <th>Trabajador</th>
              <th>Días Trabajados</th>
              <th>Dias NO Trabajados</th>
              <th>RC-IVA 13%</th>
              <th>Descuentos</th>
              <th>Saldo Tributario</th>
              <th>Liquido Pagable</th>
              <th>Total descuentos</th>
              <th>Inicio Contrato</th>
              <th>Fin Contrato</th>
            </tr>
          </thead>
          <tbody>
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
    </div>
  </div>
</template>
<script>
import row from "./row.vue";
import EditRow from "./EditRow.vue";
import VueScrollingTable from "vue-scrolling-table";

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
          this.allItems = response.data.payrolls;
        })
        .catch(error => {
          console.log(error);
        });
    } else {
      axios
        .get("/api/contracts", {
          params: {
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
      return this.allItems.slice(0, this.maxRows);
    }
  },
  mounted() {
    setTimeout(() => {
      let table = $("#payroll-table").DataTable({
        scrollY: "50vh",
        scrollCollapse: true,
        paging: false,
        dom: '<"html5buttons"B>lTfgitp',
        buttons: [
          // { extend: "copy" },
          // { extend: "excel" },
        ]
      });

      $("#payroll-table tbody").on("mouseenter", "td", function() {
        let colIdx = table.cell(this).index().column;
        $(table.cells().nodes()).removeClass("highlight");
        $(table.column(colIdx).nodes()).addClass("highlight");
      });
    }, 1500);
  }
};
</script>
<style>
td.highlight {
  background-color: #e3eaef !important;
}

#payroll-table tbody tr:hover td,
#payroll-table tbody tr:hover th {
  background-color: #e3eaef;
}
</style>