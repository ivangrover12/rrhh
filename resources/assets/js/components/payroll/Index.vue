<template>  
  <div id="app">
    <div class="ibox" id="panel">
      <div class="ibox-title">
        <h5>Total Empleados ({{ total_employees }}) | Total Contratos ({{ total }})</h5>
        <div class="ibox-tools">
          <a class="fullscreen-link" id="btnFullScreen">
            <i class="fa fa-expand"></i>
          </a>
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
              <th>Días Trab.</th>
              <th>Dias NO Trab.</th>
              <th>RC-IVA 13%</th>
              <th>
                <span type="button" class="btn btn-outline btn-link" data-toggle="tooltip" data-placement="right" data-html="true" :title="discount">Descuentos</span>
              </th>
              <th>
                <span type="button" class="btn btn-outline btn-link" data-toggle="tooltip" data-placement="right" data-html="true" data-selector="false" :title="previous_balance">Saldo Tributario</span>
              </th>
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
              v-if="!edit">
            </row>
            <edit-row v-for="(value, index) in payrolls"
              :key="`payroll-${index}`"
              :cont="index"
              :payroll="value"
              :procedure="procedure"
              v-if="edit">
            </edit-row>
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
      total_employees: 0,
      contracts: [],
      payrolls: [],
      discount: `Descuento:`,
      previous_balance: `Saldo tributario del mes anterior (Plannilla tributaria. A-3)`
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
          this.total_employees = response.data.total_employees;
          this.allItems = response.data.payrolls;
          return new Promise((resolve, reject) => {
            setTimeout(() => {
              return resolve();
            }, 50);
          })
        })
        .then(() => {
          this.initDataTables();
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
          this.total_employees = response.data.total_employees;
          this.allItems = response.data.contracts;
          return new Promise((resolve, reject) => {
            setTimeout(() => {
              return resolve();
            }, 50);
          })
        })
        .then(() => {
          this.initDataTables();
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
  methods: {
    initDataTables () {
      let table = $('#payroll-table').DataTable({
        autoWidth: false,
        scrollX: '100%',
        scrollY: '50vh',
        scrollCollapse: true,
        paging: false,
        dom: '<"html5buttons"B>lTfgitp',
        buttons: [
          // { extend: "copy" },
          // { extend: "excel" },
        ]
      }).columns.adjust();

      $('#payroll-table tbody').on('mouseenter', 'td', function() {
        let colIdx = table.cell(this).index().column;
        $(table.cells().nodes()).removeClass('highlight');
        $(table.column(colIdx).nodes()).addClass('highlight');
      });

      $('#btnFullScreen').click(function() {
        let panel = $('#panel');
        if($('#panel').hasClass('fullscreen')) {
          $('.dataTables_scrollBody').css('max-height', '75vh');
          table.columns.adjust().draw();
        } else {
          $('.dataTables_scrollBody').css('max-height', '50vh');
          table.columns.adjust().draw();
        }
      });
    }
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

#payroll-table tbody tr td.nameBox {
  min-width: 11em
}

#payroll-table tbody tr td input.inputBox {
  width: 5em
}
</style>