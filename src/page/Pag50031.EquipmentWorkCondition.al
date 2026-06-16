page 50031 "Equipment Work Condition"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "General value";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description for the equipment type.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        // Code to execute when the page is opened
        Rec.Type := Rec.Type::"Work Condition";
    end;

    trigger OnAfterGetCurrRecord()
    begin
    end;


}