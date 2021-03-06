class Admin::ProfessoresController < ApplicationController
	before_action :set_professor, only: [:update, :destroy, :edit]
    layout 'admin'
    
    def new
        @professor = Professor.new
    end

    def index
        @professor = Professor.new
        @professores = Professor.order('updated_at DESC').all
    end

	def edit
	end

	def destroy
        @em_orientacao = Trabalho.where(orientador: @professor.id)
        @em_avaliacao_1 = Trabalho.where(banca_1: @professor.id).where.not(estado: "Recebido do Aluno")
        @em_avaliacao_2 = Trabalho.where(banca_2: @professor.id).where.not(estado: "Recebido do Aluno")
        
        if @em_orientacao.empty? and @em_avaliacao_1.empty? and @em_avaliacao_2.empty?
            if @professor.destroy
                redirect_to admin_professores_path, notice: "Professor Excluido"
            else
                redirect_to admin_professores_path, notice: "Erro ao excluir Professor"
            end
        else
            redirect_to admin_professores_path, alert: "Não é possível excluir esse professor. Ele está em Orientação ou recebeu um Trabalho como Avaliador"
        end
	end

    def edit
		@professor = Professor.find(params[:id])
	end

    def update
        @professor = Professor.find(params[:id])
        if @professor.update professor_params
		  	flash[:notice] = "Professor atualizado com sucesso"
			redirect_to admin_professores_path
        else
		  	flash[:alert] = "Erro na atualização"
            redirect_to admin_professores_path
        end
    end

    private
	def set_professor
		@professor = Professor.find(params[:id])
	end
    def professor_params
        params.require(:professor).permit(:nome, :email)
    end
end
