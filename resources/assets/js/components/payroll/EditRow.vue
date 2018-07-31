<template>
    <tr>
        <td>{{ this.cont+1 }}</td>
        <td><span type="button" class="btn btn-outline btn-link nameBox" data-toggle="tooltip" data-placement="right" data-html="true" :title="positionSalary">{{ fullName(payroll) }}</span></td>
        <td>
            <input type="hidden" v-model="workedDays" :name="`contract-${payroll.contract_id}[]`" min="0" max="30" readonly>{{ workedDays }}
        </td>
        <td>
            <input type="number" v-model="unworkedDays" :name="`contract-${payroll.contract_id}[]`" class="form-control inputBox" placeholder="dias NO trabajados" min="0" :max="workedDays+unworkedDays" required>
        </td>
        <td>
            <input type="text" class="form-control inputBox" :name="`contract-${payroll.contract_id}[]`" v-model="rcIva">
        </td>
        <td>
            <input type="text" class="form-control inputBox" :name="`contract-${payroll.contract_id}[]`" v-model="delay">
        </td>
        <td>
            <input type="text" class="form-control inputBox" :name="`contract-${payroll.contract_id}[]`" :value="previousMonth"> {{ previousMonthBalance(payroll) }}
        </td>
        <td> {{ total | currency}} </td>
        <td> {{ totalDiscounts | currency }} </td>
        <td>{{ payroll.contract.date_start | formatDate }}</td>
        <td>{{ payroll.contract.date_end | formatDate }}</td>
    </tr>
</template>

<script>
export default {
  props:['cont', 'payroll', 'procedure'],
  data(){
    return{
        unworkedDays: this.payroll.unworked_days,
        di: null,
        baseWage: this.payroll.base_wage,
        delay: this.payroll.discount_faults,
        rcIva: this.payroll.discount_rc_iva,
        previousMonth: 0,
        positionSalary: `Cargo: ${this.payroll.position} \nHaber Basico: Bs. ${this.payroll.base_wage}`
    }
  },
  created(){
    //   console.log(this.payroll);
  },
  methods:{
      fullName(payroll){
          let name = `${payroll.last_name || ''} ${payroll.mothers_last_name || ''} ${payroll.surname_husband || ''} ${payroll.first_name || ''} ${payroll.second_name || ''} `
          name = name.replace(/\s+/gi, ' ').trim().toUpperCase();
          return name;
      },
      calculateDiscount(discount){
          return (this.quotable * discount)/100;
      },
      calculateTotalDiscountLaw(){
        return this.calculateDiscount(this.procedure.discount_old)+this.calculateDiscount(this.procedure.discount_common_risk)+this.calculateDiscount(this.procedure.discount_commission)+this.calculateDiscount(this.procedure.discount_solidary)+this.calculateDiscount(this.procedure.discount_national);
      },
      previousMonthBalance(payroll) {
        this.previousMonth = payroll.previous_month_balance;
      }
  },
  computed:{
      workedDays() {
        return this.payroll.worked_days + this.payroll.unworked_days - this.unworkedDays;
      },
      total(){
          return this.quotable - this.totalDiscounts;
      },
      totalDiscounts(){
          return this.calculateTotalDiscountLaw() + parseFloat(this.delay || 0 );
      },
      quotable()  {
          return (this.baseWage/30)*this.workedDays;
      },
      salary(){
          return this.quotable - this.calculateTotalDiscountLaw();
      }
  },
}
</script>