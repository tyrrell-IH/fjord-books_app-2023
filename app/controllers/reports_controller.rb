class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show edit update destroy ]

  # GET /reports or /reports.json
  def index
    @reports = Report.order(created_at: :desc).page(params[:page])
  end

  # GET /reports/1 or /reports/1.json
  def show
    @comment = Comment.new
    @commentable = @report
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports or /reports.json
  def create
    @report = current_user.reports.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Report.model_name.human) }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to report_url(@report), notice: t('controllers.common.notice_update', name: Report.model_name.human) }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    respond_to do |format|
      if @report.user_id == current_user.id
        @report.destroy
        format.html { redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human) }
      else
        format.html { redirect_back(fallback_location: root_path, notice: "Report was not destroyed.") }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:title, :body, :user_id)
    end
end
