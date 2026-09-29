page 50085 Persons
{
    ApplicationArea = All;
    Caption = 'Persons';
    PageType = List;
    SourceTable = Persons;
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Person ID"; Rec."Person ID")
                {
                    ToolTip = 'Specifies the value of the Id field.', Comment = '%';
                }
                field(name; Rec.name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(email; Rec.email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field(contact; Rec.contact)
                {
                    ToolTip = 'Specifies the value of the Phone Contact field.', Comment = '%';
                }
                field(title; Rec.title)
                {
                    ToolTip = 'Specifies the value of the Title field.', Comment = '%';
                }
                field("work location"; Rec."work location")
                {
                    ToolTip = 'Specifies the value of the Work Location field.', Comment = '%';
                }
                field("site manager"; Rec."site manager")
                {
                    ToolTip = 'Specifies the value of the Site Manager field.', Comment = '%';
                }
            }
        }
    }
}
