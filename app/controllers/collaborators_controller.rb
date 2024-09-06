# frozen_string_literal: true

# CollaboratorsController manages the CRUD operations for Collaborators.
class CollaboratorsController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :require_user
  before_action :authorize_admin, only: [:report]
  before_action :set_collaborator, only: %i[show edit update destroy]

  # GET /collaborators or /collaborators.json
  def index
    @collaborators = if current_user.admin?
                       Collaborator.page(params[:page]).per(5)
                     else
                       current_user.collaborators.page(params[:page]).per(5)
                     end
  end

  # GET /collaborators/1 or /collaborators/1.json
  def show
    authorize! :read, @collaborator
  end

  # GET /collaborators/new
  def new
    @collaborator = Collaborator.new
  end

  # GET /collaborators/1/edit
  def edit; end

  def calculate_inss_discount
    salary = params[:salary]

    @response = Collaborators::InssCalculator.new(salary)

    @response.prepare_inss

    respond_to do |format|
      format.js { render json: { inss_discount: @response.prepare_inss }, status: :ok }
    end
  end

  # POST /collaborators or /collaborators.json
  def create
    @collaborator = Collaborator.new(collaborator_params)
    respond_to do |format|
      if @collaborator.save
        format.html { redirect_to @collaborator, notice: 'Colaborador foi criado com sucesso!!' }
        format.json { render :show, status: :created, location: @collaborator }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collaborators/1 or /collaborators/1.json
  def update
    respond_to do |format|
      if @collaborator.update(collaborator_params)
        format.html { redirect_to @collaborator, notice: 'Colaborador foi editado com sucesso!!.' }
        format.json { render :show, status: :ok, location: @collaborator }
      else
        # Exibir os erros de validação
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collaborators/1 or /collaborators/1.json
  def destroy
    @collaborator.destroy
    respond_to do |format|
      format.html { redirect_to collaborators_url, notice: 'Colaborador removido com sucesso!!' }
      format.json { head :no_content }
    end
  end

  def report
    @report_data = Collaborators::GroupBySalaryBracketService.new.call
  end

  private

  def set_collaborator
    @collaborator = Collaborator.find(params[:id])
    authorize! :read, @collaborator
  end

  def collaborator_params
    params.require(:collaborator).permit(
      :name,
      :cpf,
      :birthday,
      :address,
      :number,
      :neighborhood,
      :city,
      :state,
      :postal_code,
      :personal_phone_number,
      :reference,
      :reference_phone_number,
      :salary,
      :inss_discount
    ).merge(user: current_user)
  end
end
