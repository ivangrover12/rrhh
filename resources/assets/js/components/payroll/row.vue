<template>
    <tr>
        <td>{{ contract.identity_card}} {{ contract.city_identity_card }}</td>
        <td>{{ fullName(contract) }}</td>
        <td>{{ contract.account_number}}</td>
        <td>{{ contract.birth_date | formatDate }}</td>
        <td>{{ contract.date_start | formatDate }}</td>
        <td>{{ contract.date_end | formatDate }}</td>
        <td>{{ contract.charge}}</td>
        <td>{{ contract.position }}</td>
        <td><input type="number" v-model="unworkedDays" :name="`contract-${contract.id}[]`" class="form-control" placeholder="dias NO trabajados" min="0" :max="workedDays+unworkedDays" required></td>
        <td>
            <input type="hidden" v-model="workedDays" :name="`contract-${contract.id}[]`" class="form-control" min="0" max="30" readonly>{{ workedDays }}
        </td>
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
        <td>
          <input type="text" class="form-control" :name="`contract-${contract.id}[]`" :value="previousMonth">{{ getPreviousMoth(contract) }}
        </td>
    </tr>
</template>

<script>
export default {
  props:['cont','contract', 'procedure'],
  data(){
    return{
        unworkedDays: 0,
        baseWage: this.contract.base_wage,
        delay: 0,
        rcIva: 0,
        previousMonth: 0,
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
      getPreviousMoth(contract){
        axios
          .get("/payroll/show_payroll_previous_month/" + contract.employee_id + "/" + this.procedure.id)
          .then(response => {
            this.previousMonth = response.data.next_month_balance;
          })
          .catch(error => {
            console.log(error);
          });
      }
  },
  computed:{
      workedDays() {
        let lastDayOfMonth = new Date(2018, this.procedure.month_id+1, 0).getDate();

        let payrollDate = {
            year: this.procedure.year,
            month: this.procedure.month_id,
        }

        let dateStart = {
            day: new Date(this.contract.date_start).getDate() + 1,
            year: new Date(this.contract.date_start).getFullYear(),
            month: new Date(this.contract.date_start).getMonth() + 1,
        }

        let dateEnd = {
            day: new Date(this.contract.date_end).getDate() + 1,
            year: new Date(this.contract.date_end).getFullYear(),
            month: new Date(this.contract.date_end).getMonth() + 1,
        }

        let workedDays = 0;

        if (this.contract.date_end == null) {
            workedDays = 30;
        } else if (dateStart.year == dateEnd.year && dateStart.month == dateEnd.month) {
            if (dateEnd.day == lastDayOfMonth && (lastDayOfMonth < 30 || lastDayOfMonth > 30)) {
                workedDays = 30 - dateStart.day;
            } else {
                workedDays = dateEnd.day - dateStart.day;
            }
            workedDays += 1;
        } else if (dateStart.year <= payrollDate.year && dateStart.month == payrollDate.month) {
            workedDays = 30 + 1 - dateStart.day;
        } else if (dateEnd.year >= payrollDate.year && dateEnd.month == payrollDate.month) {
            workedDays = dateEnd.day;
        } else if ((dateStart.year <= payrollDate.year && dateStart.month < payrollDate.month) || (dateEnd.year >= payrollDate.year && dateEnd.month > payrollDate.month)) {
            workedDays = 30;
        } else {
            workedDays = 0;
        }

        if (this.unworkedDays > workedDays) {
            return 0;
        } else {
            return (workedDays - this.unworkedDays);
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
          return (this.baseWage/30) * this.worked_days;
      },
      salary(){
          return this.quotable - this.calculateTotalDiscountLaw();
      }
  },
}
</script>
