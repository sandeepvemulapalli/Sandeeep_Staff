class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
   @employees = Employee.all  
  end
  
  def sort_by_age
   @employees = Employee.order(:age)
  end

   def sort_by_department
     @employees = Employee.order(:department_id)
   end
   
   def sort_by_salary
     @employees = Employee.order(:salary)
   end
   
   def retiredemp
     @employees = Employee.where('age > ?', 65)
   end
   
   def top_5_salary
     @employees = Employee.order(salary: :desc).limit(5)
   end
   
   def high_paid
     @employees = Employee.order(salary: :desc).limit(1)
   end
   
   def top_5_senior_by_age
	 @employees =  Employee.order(age: :desc).limit(5) 
   end
   
   def low_salary_senior_company
     @employees = Employee.order(:salary, age: :desc).limit(1)
   end
   
   
  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :email, :age, :salary, :department_id)
    end
end
