module RenderHelper
  def job_is_complete(jid)
      waiting  = Sidekiq::Queue.new
      working  = Sidekiq::Workers.new
      pending  = Sidekiq::ScheduledSet.new
      retrying = Sidekiq::RetrySet.new

      return false if retrying.find { |job| job.jid == jid }
      return false if pending.find { |job| job.jid == jid }
      return false if waiting.find { |job| job.jid == jid }
      return false if working.find { |worker, info| info["payload"]["jid"] == jid }
      true
  end

  def job_current_state(jid)
    job = RenderQueue.where(job_id: jid).first
    return job.nil? ? 'done' : job.stage
  end
end
