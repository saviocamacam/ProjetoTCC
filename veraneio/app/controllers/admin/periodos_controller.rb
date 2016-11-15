class Admin::PeriodosController < ApplicationController
  layout 'admin'
  before_action :set_admin_periodo, only: [:show, :edit, :update, :destroy]

  # GET /admin/periodos
  # GET /admin/periodos.json
  def index
    @admin_periodos = Periodo.all
  end

  # GET /admin/periodos/1
  # GET /admin/periodos/1.json
  def show
  end

  # GET /admin/periodos/new
  def new
    @admin_periodo = Periodo.new
  end

  # GET /admin/periodos/1/edit
  def edit
  end

  # POST /admin/periodos
  # POST /admin/periodos.json
  def create
    @admin_periodo = Periodo.new(admin_periodo_params)

    respond_to do |format|
      if @admin_periodo.save
        format.html { redirect_to admin_periodos_path, notice: 'Período criado com sucesso.' }
        format.json { render :show, status: :created, location: @admin_periodo }
      else
        format.html { render :new }
        format.json { render json: @admin_periodo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/periodos/1
  # PATCH/PUT /admin/periodos/1.json
  def update
    respond_to do |format|
      if @admin_periodo.update(admin_periodo_params)
        format.html { redirect_to @admin_periodo, notice: 'Período atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @admin_periodo }
      else
        format.html { render :edit }
        format.json { render json: @admin_periodo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/periodos/1
  # DELETE /admin/periodos/1.json
  def destroy
    @admin_periodo.destroy
    respond_to do |format|
      format.html { redirect_to admin_periodos_url, notice: 'Período foi apagado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_periodo
      @admin_periodo = Periodo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_periodo_params
      params.require(:periodo).permit(:inicio, :termino)
    end
end
