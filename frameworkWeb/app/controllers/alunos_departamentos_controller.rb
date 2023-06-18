class AlunosDepartamentosController < ApplicationController
    before_action :authenticate_user!
    def index
        @aldp = AlunosDepartamento.all
    end

    def create
        aluno = Aluno.find(params[:aluno_id])
        departamento = Departamento.find(params[:departamento_id])
        
        @aluno_departamento = AlunosDepartamento.new(aluno: aluno, departamento: departamento)
        
        if @aluno_departamento.save
            redirect_to alunos_departamentos_path
        else
            render :new
        end
    end

    def destroy
        @aln = Aluno.find(params[:id])
        @aln.destroy
    end
    
      private
    
      def aluno_departamento_params
        params.require(:aluno_departamento).permit(:aluno_id, :departamento_id)
      end
end
  