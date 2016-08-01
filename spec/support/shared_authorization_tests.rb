RSpec.shared_examples 'unauthorized' do
  context 'when the user is not logged in' do
    it 'should redirect to root' do
      get :index
      expect(response).to redirect_to(root_path)
    end
  end
end
