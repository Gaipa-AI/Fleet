page 50088 "User Location Setup"
{
    ApplicationArea = All;
    Caption = 'User Location Setup';
    PageType = List;
    SourceTable = "User Location Setup";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Loc; Rec.Loc)
                {
                    ToolTip = 'Specifies the value of the Loc field.', Comment = '%';
                }
                field(Check; Rec.Check)
                {
                    ToolTip = 'Specifies the value of the Check field.', Comment = '%';
                }
                field(CMR; Rec.CMR)
                {
                    ToolTip = 'Specifies the value of the CMR field.', Comment = '%';
                }
            }
        }
    }
}
