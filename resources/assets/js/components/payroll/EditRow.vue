<template>
    <tr>
        <td>{{ payroll.identity_card}} {{ payroll.city_identity_card }}</td>
        <td>{{ fullName(payroll) }}</td>
        <td>{{ payroll.account_number}}</td>
        <td>{{ payroll.birth_date | formatDate }}</td>
        <td>{{ payroll.contract.date_start | formatDate }}</td>
        <td>{{ payroll.contract.date_end | formatDate }}</td>
        <td>{{ payroll.charge}}</td>
        <td>{{ payroll.position }}</td>
        <td><input type="number" v-model="unworkedDays" :name="`contract-${payroll.contract_id}[]`" class="form-control" placeholder="dias NO trabajados" min="0" :max="workedDays+unworkedDays" required></td>
        <td>
            <input type="hidden" v-model="workedDays" :name="`contract-${payroll.contract_id}[]`" class="form-control" min="0" max="30" readonly>{{ workedDays }}
        </td>
        <td>{{ baseWage | currency }}</td>
        <td>{{ quotable | currency }}</td>
        <td>{{ payroll.management_entity}}</td>
        <td>{{ calculateDiscount(procedure.discount_old) | currency }}</td>
        <td>{{ calculateDiscount(procedure.discount_common_risk) | currency }}</td>
        <td>{{ calculateDiscount(procedure.discount_commission) | currency }}</td>
        <td>{{ calculateDiscount(procedure.discount_solidary) | currency }}</td>
        <td>{{ calculateDiscount(procedure.discount_national) | currency }}</td>
        <td>{{ calculateTotalDiscountLaw() | currency }}</td>
        <td>{{ salary | currency}}</td>
        <td><input type="text" class="form-control" :name="`contract-${payroll.contract_id}[]`" v-model="rcIva"></td>
        <td><input type="text" class="form-control" :name="`contract-${payroll.contract_id}[]`" v-model="delay"></td>
        <td> {{ totalDiscounts | currency }} </td>
        <td> {{ total | currency}} </td>
    </tr>
</template>

<script>
export default {
  props:['payroll', 'procedure'],
  data(){
    return{
        unworkedDays: this.payroll.unworked_days,
        di: null,
        baseWage: this.payroll.base_wage,
        delay: this.payroll.discount_faults,
        rcIva: this.payroll.discount_rc_iva,
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

  },
  computed:{
      workedDays() {
        return this.payroll.worked_days - this.unworkedDays;
      },
      total(){
          return this.quotable - this.totalDiscounts;
      },
      totalDiscounts(){
          return this.calculateTotalDiscountLaw() + parseFloat(this.delay || 0 ) + parseFloat(this.rcIva || 0);
      },
      quotable()  {
          return (this.baseWage/30)*(30 - this.unworkedDays);
      },
      salary(){
          return this.quotable - this.calculateTotalDiscountLaw();
      }
  },
}
</script>