global class updateOpportunityTeamMemberAccess2 implements Process.Plugin { 

   global Process.PluginResult invoke(Process.PluginRequest request) { 
      String opportunityTeamMemberUserID = (String) request.inputParameters.get('vOpportunityTeamMemberID');
      String opportunityID = (String) request.inputParameters.get('vOpportunityID');
      
      String updateSOQL = 'select Id, OpportunityAccessLevel, RowCause from OpportunityShare where UserOrGroupID = \'' + opportunityTeamMemberUserID + '\' and RowCause = \'Team\' and OpportunityID = \'' + opportunityID + '\'';
      
      
      // get the team member's sharing records
      OpportunityShare otm = Database.query(updateSOQL);
      
      // set team member's access to read/write
      otm.OpportunityAccessLevel = 'Edit';

      update otm;
      
      return null;
     
   }

   global Process.PluginDescribeResult describe() { 
      Process.PluginDescribeResult result = new Process.PluginDescribeResult(); 
      result.Name = 'Update Opportunity Team Member Access';
      result.Tag = 'Opportunity Classes';
      result.inputParameters = new 
         List<Process.PluginDescribeResult.InputParameter>{ 
            new Process.PluginDescribeResult.InputParameter('vOpportunityTeamMemberID', 
            Process.PluginDescribeResult.ParameterType.STRING, true),
            new Process.PluginDescribeResult.InputParameter('vOpportunityID', 
            Process.PluginDescribeResult.ParameterType.STRING, true) 
         }; 
     
     return null;
     
   }
}