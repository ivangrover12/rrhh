<template>
    <tr>
        <td>{{ contract.identity_card}} {{ contract.city_identity_card }}</td>
        <td>{{ fullName(contract) }}</td>
        <td>{{ contract.account_number}}</td>
        <td>{{ contract.birth_date}}</td>
        <td>{{ contract.charge}}</td>
        <td>{{ contract.position }}</td>
        <td><input type="number" v-model="unworked_days" :name="`contract-${contract.id}[]`" class="form-control" placeholder="dias NO trabajados" min="0" max="30"></td>
        <td>{{ worked_days }}</td>
        <td>{{ baseWage | currency }}</td>
        <td>{{ quotable | currency }}</td>
        <td>{{ contract.management_entity}}</td>
        <td>{{ calculateDiscount(procedure.discount_old) | currency }}</td>
        <td>{{ calculateDiscount(procedure.discount_common_risk) | currency }}</td>
        <td>{{ calculateDiscount(procedure.discount_commission) | currency }}</td>
        <td>{{ calculateDiscount(procedure.discount_solidary) | currency }}</td>
        <td>{{ calculateDiscount(procedure.discount_national) | currency }}</td>
        <td>{{ calculateTotalDiscountLaw() | currency }}</td>
        <td>{{ salary | currency}}</td>
        <td><input type="text" class="form-control" :name="`contract-${contract.id}[]`" v-model="rcIva"></td>
        <td><input type="text" class="form-control" :name="`contract-${contract.id}[]`" v-model="delay"></td>
        <td> {{ totalDiscounts | currency }} </td>
        <td> {{ total | currency}} </td>
    </tr>
</template>

<script>
export default {
  props:['cont','contract', 'procedure'],
  data(){
    return{
        unworked_days: 0,
        baseWage: this.contract.base_wage,
        delay: 0,
        rcIva: 0,
    }
  },
  created(){
    //   console.log(this.contract);
  },
  methods:{
      fullName(contract){
          let name = `${contract.last_name || ''} ${contract.mothers_last_name || ''} ${contract.surname_husband || ''} ${contract.first_name || ''} ${contract.second_name || ''}  `
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
      worked_days() {
        let payroll_date = {
            year: this.procedure.year,
            month: this.procedure.month_id,
        }

        let date_start = {
            day: new Date(this.contract.date_start).getDate() + 1,
            year: new Date(this.contract.date_start).getFullYear(),
            month: new Date(this.contract.date_start).getMonth() + 1,
        }

        let date_end = {
            day: new Date(this.contract.date_end).getDate() + 1,
            year: new Date(this.contract.date_end).getFullYear(),
            month: new Date(this.contract.date_end).getMonth() + 1,
        }

        let worked_days = 0;

        if (this.contract.date_end == null) {
            worked_days = 30;
        } else if (date_start.year <= payroll_date.year && date_start.month == payroll_date.month) {
            worked_days = 30 + 1 - date_start.day;
        } else if (date_end.year >= payroll_date.year && date_end.month == payroll_date.month) {
            worked_days = date_end.day;
        } else if ((date_start.year <= payroll_date.year && date_start.month < payroll_date.month) || (date_end.year >= payroll_date.year && date_end.month > payroll_date.month)) {
            worked_days = 30;
        } else {
            worked_days = 0;
        }

        if (this.unworked_days > worked_days) {
            return 0;
        } else {
            return (worked_days - this.unworked_days);
        }

        return 30;
      },
      total(){
          return this.quotable - this.totalDiscounts;
      },
      totalDiscounts(){
          return this.calculateTotalDiscountLaw() + parseFloat(this.delay || 0 ) + parseFloat(this.rcIva || 0);
      },
      quotable()  {
          return (this.baseWage/30)*(30 - this.unworked_days);
      },
      salary(){
          return this.quotable - this.calculateTotalDiscountLaw();
      }
  },
}
</script>
