<template>
    <tr>
        <td>{{ contract.identity_card}} {{ contract.city_identity_card }}</td>
        <td>{{ fullName(contract) }}</td>
        <td>{{ contract.account_number}}</td>
        <td>{{ contract.birth_date}}</td>
        <td>{{ contract.charge}}</td>
        <td>{{ contract.position }}</td>
        <td><input type="number" v-model="days" :name="`contract-${contract.id}[]`" class="form-control" placeholder="dias trabajados" min="0" max="30"></td>
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
        days: 30,
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
      total(){
          return this.quotable - this.totalDiscounts;
      },
      totalDiscounts(){
          return this.calculateTotalDiscountLaw() + parseFloat(this.delay || 0 ) + parseFloat(this.rcIva || 0);
      },
      quotable()  {
          return (this.baseWage/30)*this.days;
      },
      salary(){
          return this.quotable - this.calculateTotalDiscountLaw();
      }
  },
}
</script>
