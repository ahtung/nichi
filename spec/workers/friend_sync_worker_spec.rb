require 'rails_helper'

RSpec.describe FriendSyncWorker, type: :worker do
  it { is_expected.to be_processed_in :default }
  it { is_expected.to be_retryable false }
  xit { is_expected.to be_unique }
  xit { is_expected.to be_expired_in 1.hour }
end
